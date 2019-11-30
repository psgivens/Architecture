# Overview

## Work arounds

**Hot Reload** is broken (at least in Ubuntu 18.04) in the create-react-app setup. [Here](https://stackoverflow.com/questions/42189575/create-react-app-reload-not-working) is a fix.

    sudo -i
    echo 1048576 > /proc/sys/fs/inotify/max_user_watches
    exit

## Creating the react/redux app

Create the project

    npx create-react-app webapp --typescript
    cd webapp

Add dependencies    

    npm install --save "@types/d3"
    npm install --save "@types/react-redux"
    npm install --save "@types/react-router-dom"
    npm install --save "@types/reduce-reducers"
    npm install --save "@types/redux"
    npm install --save "@types/redux-saga"
    npm install --save "node-sass-chokidar"
    
    npm install --save redux react-redux

Add these scripts to package.json

      "build-css": "node-sass-chokidar --include-path ./src --include-path ./node_modules src/ -o src/",
      "watch-css": "npm run build-css && node-sass-chokidar --include-path ./src   --include-path ./node_modules src/ -o src/ --watch --recursive",

Create a counter saga ./src/basic/actions/counterSaga.ts

    import { takeEvery } from 'redux-saga/effects'
    import { put } from 'redux-saga/effects'
    
    export type CounterCommand = {
        type: "COUNTER_INCREMENT"
    } | {
        type: "COUNTER_DECREMENT"
    } 
    
    export const CounterCommands = {
        incrementCounter: ():CounterCommand => ({ type: "COUNTER_INCREMENT" })
    } 
    
    export type CounterEvent = {
        type: "COUNTER_INCREMENT_FAILED"
    } | {
        type: "COUNTER_INCREMENT_SUCCESS"
    }
        
    /************************ SAGA *********************/
    export class CounterSaga {
        constructor () {
            this.saga = this.saga.bind(this)
            this.incrementCounter = this.incrementCounter.bind(this)
        }
    
        /*************** Register listeners ********************/
        public *saga(): Iterator<any> {
            yield takeEvery('COUNTER_INCREMENT', (command:CounterCommand) => this.incrementCounter(command))        
        }
    
        public *incrementCounter(action: CounterCommand){
    
            yield put( { 
                type: "COUNTER_INCREMENT_SUCCESS"
            } as CounterEvent)
        }
    
    }

Create a counter reducer ./src/basic/counterReducer.ts
    
    import { CounterEvent } from '../actions/CounterSaga'
    
    export function counterReducers(state:number=0, action: CounterEvent): number {
        switch (action.type) {
            case "COUNTER_INCREMENT_SUCCESS": return state + 1
            default: return state
        }
    }
    
Create an reducers aggregate in ./src/basic/reducers/index.ts

    import { combineReducers } from 'redux';
    import { counterReducers } from './counterReducers';
    
    export type All = {} & {
      counter: number
    }  
    
    export const initialState =  { 
      counter: 0
    }
    
    export const reducers = combineReducers( {
      counter: counterReducers
      })

Create an appContainer for the default App.tsx: ./src/basic/appComponent/appContainer.ts

    import { connect } from 'react-redux';
    import * as redux from 'redux';
    import { CounterCommand, CounterCommands } from '../basic/actions/CounterSaga';
    import * as state from '../basic/reducers'

    export type AttributeProps = {} & {
    }
      
    export type StateProps = {} & {
        counter?: number
    }
      
    export type ConnectedDispatch = {} & {
        incrementCounter?:() => void
    }
    
    type internalState = {} & {
        counter: number
        values: string []
      }  
      
    const mapStateToProps = (state1: state.All, ownProps: AttributeProps): StateProps => {
        return {
            counter: state1.counter
        } }
    
    const mapDispatchToProps = (dispatch: redux.Dispatch<CounterCommand>): ConnectedDispatch => {
        return {
            incrementCounter: () => dispatch(CounterCommands.incrementCounter())
        }
    }    
    
    export const connectContainer = 
        connect<{}, {}, AttributeProps, state.All>(mapStateToProps, mapDispatchToProps)
      


Add saga infrastructure to ./src/index.tsx

    import { Provider } from 'react-redux'
    import createSagaMiddleware from 'redux-saga'
    import { applyMiddleware, createStore, Store as ReduxStore } from 'redux'
    import { reducers } from './basic/reducers'
    import * as state from './basic/reducers'
    
    import { CounterSaga } from './basic/actions/CounterSaga'  
    
    const initialState = { 
      counter: 0
    }
    
    const sagaMiddleware = createSagaMiddleware()
    const store: ReduxStore<state.All> = createStore(reducers, initialState, applyMiddleware(sagaMiddleware))    
    const counterSaga = new CounterSaga()    
    sagaMiddleware.run(counterSaga.saga)
    
    // Replacement for: ReactDOM.render(<App />, document.getElementById('root'));
    ReactDOM.render(
        <Provider store={store}><App /></Provider>,
        document.getElementById('root') as HTMLElement
      )
    



  